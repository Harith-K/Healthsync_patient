from django.db import models

class Patient(models.Model):
    first_name = models.CharField(max_length=50)
    last_name = models.CharField(max_length=50)
    dob = models.DateField()  # Date of birth
    gender = models.CharField(max_length=10, choices=[('Male', 'Male'), ('Female', 'Female')])
    phone_number = models.CharField(max_length=15)
    address = models.TextField()
    medical_history = models.TextField()
    prescriptions = models.TextField()
    lab_results = models.TextField()

    def __str__(self):
        return f"{self.first_name} {self.last_name}"