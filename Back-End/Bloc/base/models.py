from django.db import models
from django.contrib.auth.models import User
from django.core.files.base import ContentFile
from django.db import models
import base64
# Create your models here.



class EventCategory(models.Model):
    name = models.CharField(max_length=50, unique=True)

    def __str__(self):
        return self.name

class Event(models.Model):
    def save_picture_from_base64(self, base64_image):
        # Decode the base64 string into binary data
        image_data = base64.b64decode(base64_image)

        # Create a ContentFile from the binary data
        image_content = ContentFile(image_data, name='event_picture.jpg')  # Provide a proper filename

        # Assign the ContentFile to the picture field
        self.picture.save('event_picture.jpg', image_content, save=True)
    event_name = models.CharField(max_length=150)
    lat = models.FloatField(default=0)
    long = models.FloatField(default=0)
    location_name = models.CharField(max_length=150)
    event_category = models.ForeignKey(EventCategory, on_delete=models.CASCADE)
    picture = models.ImageField(upload_to='event_pictures/')
    start_date = models.DateTimeField()
    end_date = models.DateTimeField()
    creator = models.ForeignKey(User, on_delete=models.CASCADE)  # Link to the event creator (User model)
    likes = models.IntegerField(default=0)  # Number of likes
    dislikes = models.IntegerField(default=0)  # Number of dislikes
    link = models.URLField(max_length=200, blank=True, null=True)
    distance = models.PositiveIntegerField(
        default=10, help_text='Maximum distance (in kilometers) you are willing to travel for events.'
    )
    


class EventUserPreference(models.Model):
    event = models.ForeignKey(Event, on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    preference = models.CharField(choices=[('like', 'Like'), ('dislike', 'Dislike')], max_length=7) 