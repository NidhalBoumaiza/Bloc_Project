from django.contrib import admin
from .models import EventCategory , Event,EventUserPreference

 
@admin.register(Event)
class EventAdmin(admin.ModelAdmin):
    pass


@admin.register(EventCategory)
class EventCategoryAdmin(admin.ModelAdmin):
    pass 


@admin.register(EventUserPreference)
class EventUserPreferenceAdmin(admin.ModelAdmin):
    pass 