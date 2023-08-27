import base64
from django.shortcuts import render
# Create your views here.
from rest_framework.response import Response
from .models import Event
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import AllowAny
from .misc import get_nearby_pref_cat_all_events,get_nearby_pref_cat_num_events,get_custom_pref_events
from django.http import HttpResponse
from .models import EventCategory,EventUserPreference,Event  # Import your models
from django.utils import timezone
from datetime import datetime
import pytz  # For timezone support
from django.core.files.base import ContentFile

@api_view(['PATCH'])
def location(request):
    data = request.data
    lat = data.get('lat')
    long = data.get('long')
    user = request.user
    user.profile.lat = lat
    user.profile.long = long
    user.profile.save()
    return HttpResponse('Location saved successfully' , status = 200) 





@api_view(['GET'])
def home(request):
    user = request.user
    event_type = request.query_params.get('type')
    print (event_type)
    try:
        if event_type == 'all':
            events = get_nearby_pref_cat_all_events(user)
        elif event_type == 'partial':
            events = get_nearby_pref_cat_num_events(user)
        elif event_type == 'custom':
            distance =int(request.query_params.get('distance')) 
            category = request.query_params.get('category').lower()
            events = get_custom_pref_events(user, distance, category)
        return Response({'events': events})
    except Exception as error:
        print (error)
        return HttpResponse('Something went wrong' , status = 400)
    


@api_view(['POST'])
def create_event(request):
    data = request.data
    
    event_name = data.get('event_name')
    lat = data.get('lat')
    long = data.get('long')
    location_name = data.get('location_name')
    event_category = data.get('event_category')
    event_category  = event_category.lower()
    picture = data.get('picture')
    start_date = data.get('start_date')
    end_date = data.get('end_date')
    parsed_startdatetime = datetime.strptime(start_date, "%Y-%m-%dT%H:%M:%S.%f")
    parsed_enddatetime = datetime.strptime(end_date, "%Y-%m-%dT%H:%M:%S.%f")
    aware_startdatetime = parsed_startdatetime.replace(tzinfo=pytz.utc)
    aware_enddatetime = parsed_enddatetime.replace(tzinfo=pytz.utc)
    link = data.get('link')
    distance = data.get('distance')
    creator = request.user
    event_category = EventCategory.objects.filter(name=event_category)
    event_category = event_category.first()
    print (event_category)
    try: 
        
        event = Event.objects.create(event_name=event_name,lat=lat,long=long,location_name = location_name , event_category=event_category, creator = creator, start_date=aware_startdatetime,end_date=aware_enddatetime,link=link,distance=distance)
        event.save()
        event.save_picture_from_base64(picture)
        return HttpResponse('Event created successfully' , status = 200)
    except Exception as error: 
         print (error)
         return HttpResponse('Something went wrong' , status = 400)
    


@api_view(['PATCH'])
def rateevent(request):
    data = request.data
    print (data)
    event_id = data.get('event_id')
    preference = data.get('preference')
    user = request.user
    #print (preference)
    event = Event.objects.get(pk=event_id)

    try:
        user_preference = EventUserPreference.objects.get(event=event, user=user)
        print (user_preference)
        if user_preference.preference.lower() == preference:
            # If the user's preference matches the new preference, remove the preference
            user_preference.delete()
            if preference == 'like':
                event.likes -= 1
            elif preference == 'dislike':
                event.dislikes -= 1
        else:
            # If the user's preference is different, update it
            user_preference.preference = preference
            user_preference.save()
            if preference == 'like':
                event.likes += 1
                event.dislikes -= 1  # If user changes from dislike to like
            elif preference == 'dislike':
                event.likes -= 1  # If user changes from like to dislike
                event.dislikes += 1

    except EventUserPreference.DoesNotExist:
        EventUserPreference.objects.create(event=event, user=user, preference=preference)
        if preference == 'like':
            event.likes += 1
        elif preference == 'dislike':
            event.dislikes += 1

    event.save()

    return HttpResponse(status=200)



@api_view(['GET'])
def userinfo(request):
    user = request.user
    categories = user.profile.prefered_categories.all()
    categories = [category.name for category in categories]
    return Response({"profile" : {'username': user.username, 'first_name': user.first_name, 'last_name': user.last_name,'categories':categories, 'distance': user.profile.events_distance,  }})