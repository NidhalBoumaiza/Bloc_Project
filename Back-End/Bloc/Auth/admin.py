from django.contrib import admin
from .models import Profile


@admin.register(Profile)
class ProfileAdmin(admin.ModelAdmin):
    pass  # Since you don't need any additional customization
# Register your models here.
