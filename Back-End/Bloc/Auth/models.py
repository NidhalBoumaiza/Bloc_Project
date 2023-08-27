from django.db import models
from django.contrib.auth.models import User
from base.models import EventCategory

# Create your models here.



class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, null=False, blank=False)
    prefered_categories = models.ManyToManyField(
        EventCategory, related_name='interested_users', blank=True,
        help_text='Select your preferred event categories.'
    )
    events_distance = models.PositiveIntegerField(
        default=10, help_text='Maximum distance (in kilometers) you are willing to travel for events.'
    )
    #for location tracking
    lat = models.FloatField(default=0)
    long = models.FloatField(default=0)

    def __str__(self):
        return self.user.username
