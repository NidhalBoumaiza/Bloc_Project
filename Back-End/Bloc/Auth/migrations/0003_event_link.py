# Generated by Django 4.2.3 on 2023-08-02 20:44

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('Auth', '0002_eventcategory_profile_alter_event_event_category'),
    ]

    operations = [
        migrations.AddField(
            model_name='event',
            name='link',
            field=models.URLField(blank=True, null=True),
        ),
    ]