from django.urls import path,include
from .views import create_event , location , home,rateevent , userinfo





urlpatterns = [
    path('create_event/',create_event ),
    path('update_location/',location ),
    path('home/',home ),
    path('rateevent/',rateevent),
    path('profile/',userinfo),
]
