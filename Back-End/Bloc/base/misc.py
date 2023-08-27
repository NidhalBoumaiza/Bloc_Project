import math
from .models import Event, EventCategory, EventUserPreference
from django.utils import timezone


def haversine_distance(lat1, lon1, lat2, lon2):
    # Radius of the Earth in kilometers
    earth_radius = 6371.0

    # Convert degrees to radians
    lat1_rad = math.radians(lat1)
    lon1_rad = math.radians(lon1)
    lat2_rad = math.radians(lat2)
    lon2_rad = math.radians(lon2)

    # Haversine formula
    dlat = lat2_rad - lat1_rad
    dlon = lon2_rad - lon1_rad
    a = math.sin(dlat / 2)**2 + math.cos(lat1_rad) * math.cos(lat2_rad) * math.sin(dlon / 2)**2
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))

    # Calculate distance
    distance = earth_radius * c
    return distance

# # Example usage
# lat1 = 36.736857345511105
# lon1 = 10.242784461187462
# lat2 = 36.74411793429305
# lon2 = 10.234242617777499
# distance = haversine_distance(lat1, lon1, lat2, lon2)



def get_nearby_pref_cat_all_events(user):
    user_profile = user.profile
    preferred_categories = user_profile.prefered_categories.all()
    user_lat = user_profile.lat
    user_lon = user_profile.long
    max_distance_km = user_profile.events_distance

    nearby_events = []

    current_datetime = timezone.now()
    for category in preferred_categories:
        events_in_category = category.event_set.filter(end_date__gte=current_datetime.date())

        for event in events_in_category:
            event_lat = event.lat
            event_lon = event.long
            distance = haversine_distance(user_lat, user_lon, event_lat, event_lon)
            
            if distance <= max_distance_km and distance <= event.distance:
                nearby_events.append(event)
    # Sort events by category name
    nearby_events.sort(key=lambda event: event.event_category.name)
    # Convert events data to JSON format
    events_json = []
    for event in nearby_events:
        events_json.append({
            'id': event.id,
            'name': event.event_name,
            'location_name': event.location_name,
            'event_category': event.event_category.name,
            'picture': event.picture.url,
            'start_date': event.start_date,
            'end_date': event.end_date,
            'creator': event.creator.first_name + ' ' + event.creator.last_name,
            'link': event.link,
            'score':event.likes - event.dislikes,
            'like':1 if EventUserPreference.objects.filter(user=user,event=event,preference='like').exists() else (-1 if EventUserPreference.objects.filter(user=user,event=event,preference='dislike').exists() else 0)  ,            # Add other fields you want to include in the JSON response
        })
    return events_json


def get_nearby_pref_cat_num_events(user):
    user_profile = user.profile
    preferred_categories = user_profile.prefered_categories.all()
    user_lat = user_profile.lat
    user_lon = user_profile.long
    max_distance_km = user_profile.events_distance

    nearby_events = []
    events_per_category = 3  # Number of events to retrieve per category

    current_datetime = timezone.now()
    for category in preferred_categories:
        events_in_category = category.event_set.filter(end_date__gte=current_datetime.date())

        events_added = 0  # Counter for events added for the current category
        for event in events_in_category:
            if events_added >= events_per_category:
                break  # Break if the required number of events is reached for this category
            
            event_lat = event.lat
            event_lon = event.long
            distance = haversine_distance(user_lat, user_lon, event_lat, event_lon)
            
            if distance <= max_distance_km and distance <= event.distance:
                nearby_events.append(event)
                events_added += 1
                
    # Sort events by category name
    nearby_events.sort(key=lambda event: event.event_category.name)
    
    # Convert events data to JSON format
    events_json = []
    for event in nearby_events:
        events_json.append({
            'id': event.id,
            'name': event.event_name,
            'location_name': event.location_name,
            'event_category': event.event_category.name,
            'picture': event.picture.url,
            'start_date': event.start_date,
            'end_date': event.end_date,
            'creator': event.creator.first_name + ' ' + event.creator.last_name,
            'link': event.link,
            'score': event.likes - event.dislikes,
            'like':1 if EventUserPreference.objects.filter(user=user,event=event,preference='like').exists() else (-1 if EventUserPreference.objects.filter(user=user,event=event,preference='dislike').exists() else 0)  ,            # Add other fields you want to include in the JSON response
        })
    return events_json



def get_custom_pref_events(user,distance,category):
    user_profile = user.profile
    category = EventCategory.objects.filter(name=category).first()
    user_lat = user_profile.lat
    user_lon = user_profile.long
    max_distance_km = distance

    nearby_events = []

    current_datetime = timezone.now()

    event_in_category = category.event_set.filter(end_date__gte=current_datetime.date())

    for event in event_in_category:
        event_lat = event.lat
        event_lon = event.long
        distance = haversine_distance(user_lat, user_lon, event_lat, event_lon)
        
        if distance <= max_distance_km and distance <= event.distance:
            nearby_events.append(event)
    # Sort events by category name
    nearby_events.sort(key=lambda event: event.event_category.name)
    # Convert events data to JSON format
    events_json = []
    for event in nearby_events:
        events_json.append({
            'id': event.id,
            'name': event.event_name,
            'location_name': event.location_name,
            'event_category': event.event_category.name,
            'picture': event.picture.url,
            'start_date': event.start_date,
            'end_date': event.end_date,
            'creator': event.creator.first_name + ' ' + event.creator.last_name,
            'link': event.link,
            'score':event.likes - event.dislikes,
            'like':1 if EventUserPreference.objects.filter(user=user,event=event,preference='like').exists() else (-1 if EventUserPreference.objects.filter(user=user,event=event,preference='dislike').exists() else 0)  ,            # Add other fields you want to include in the JSON response
        })
    return events_json