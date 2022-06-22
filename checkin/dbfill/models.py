from django.db import models

# Create your models here.


class Person (models.Model):
    number = models.BigIntegerField(primary_key=True)
    is_teacher = models.BooleanField

class LogDevice (models.Model):
    number = models.BigIntegerField(primary_key=True)
    location = models.TextField()

class Session (models.Model):
    number = models.BigAutoField(primary_key=True)
    creation_time = models.TimeField()
    termination_time = models.TimeField()
    creator = models.ForeignKey(Person, on_delete=models.DO_NOTHING)
    location = models.ForeignKey(LogDevice, on_delete=models.DO_NOTHING)
    students = models.CommaSeparatedIntegerField()
