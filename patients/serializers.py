from rest_framework import serializers
from .models import Patient

class PatientSerializer(serializers.ModelSerializer):
    class Meta:
        model = Patient
        fields = '__all__'

    # Validate phone number
    def validate_phone_number(self, value):
        if not value.isdigit() or len(value) != 10:
            raise serializers.ValidationError("Phone number must be a 10-digit numeric value.")
        return value

    # Validate gender
    def validate_gender(self, value):
        if value not in ['Male', 'Female']:
            raise serializers.ValidationError("Gender must be 'Male' or 'Female'.")
        return value
