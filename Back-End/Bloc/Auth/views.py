from django.contrib.auth.models import User
from django.db import IntegrityError
from rest_framework.response import Response
from rest_framework.decorators import api_view,permission_classes
from django.http import HttpResponse
from .models import Profile, EventCategory  # Import your models
from rest_framework.permissions import AllowAny
from rest_framework.authtoken.models import Token
from django.http import JsonResponse

@api_view(['POST'])
@permission_classes([AllowAny])
def register(request):
    data = request.data
    email = data.get('email')
    password = data.get('password')
    confirm_password = data.get('confirm_password')
    first_name = data.get('first_name')
    last_name = data.get('last_name')
    distance = data.get('distance')
    prefered_category_names = data.get('prefered_categories')  # Get category names directly

    for i in range(len(prefered_category_names)):
        prefered_category_names[i] = prefered_category_names[i].lower()

    if password != confirm_password:
        return Response({'error': 'Passwords do not match'})
    else:
        try:
            user = User.objects.create_user(
                username=email, email=email, password=password,
                first_name=first_name, last_name=last_name
            )
            user.save()

            # Get EventCategory instances based on provided names
            prefered_categories = EventCategory.objects.filter(name__in=prefered_category_names)
            print(prefered_categories)
            profile = Profile.objects.create(
                user=user, events_distance=distance,
            )
            
            # Set preferred_categories using ManyToMany relation
            profile.prefered_categories.set(prefered_categories)

            return Response({"message": 'User created successfully'}, status=200)
        except IntegrityError:
            return Response('User with that email already exists', status=400)
        

@api_view(['POST'])
def finish_signup(request):
    user=request.user
    data = request.data
    distance = data.get('distance')
    prefered_category_names = data.get('prefered_categories')  # Get category names directly

    for i in range(len(prefered_category_names)):
        prefered_category_names[i] = prefered_category_names[i].lower()

        try:
            # Get EventCategory instances based on provided names
            prefered_categories = EventCategory.objects.filter(name__in=prefered_category_names)
            print(prefered_categories)
            profile = Profile.objects.create(
                user=user, events_distance=distance,
            )
            
            # Set preferred_categories using ManyToMany relation
            profile.prefered_categories.set(prefered_categories)
            return Response({"message": 'User created successfully'}, status=200)
        except IntegrityError:
            return Response('User with that email already exists', status=400)
        
        



@api_view(['POST'])
def profile_exist(request):
    user=request.user
    try:
        profile = Profile.objects.get(user=user)
        return Response({"message": 'Profile exist'}, status=200)
    except Profile.DoesNotExist:
        return Response({"message": 'Profile does not exist'}, status=400)

