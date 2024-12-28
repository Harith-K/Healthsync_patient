from django.test import TestCase
from rest_framework.test import APIClient

class PatientIntegrationTest(TestCase):
    def setUp(self):
        self.client = APIClient()
        self.patient_data = {
            "first_name": "John",
            "last_name": "Doe",
            "dob": "1990-01-01",
            "gender": "Male",
            "phone_number": "1234567890",
            "address": "123 Elm Street",
            "medical_history": "None",
            "prescriptions": "Vitamin D",
            "lab_results": "Normal"
        }

    def test_full_workflow(self):
        # Step 1: Create a Patient
        response = self.client.post("/api/patients/", self.patient_data, format="json")
        self.assertEqual(response.status_code, 201)
        patient_id = response.data["id"]

        # Step 2: Retrieve All Patients
        response = self.client.get("/api/patients/")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(len(response.data), 1)

        # Step 3: Update the Patient
        updated_data = {**self.patient_data, "first_name": "Jane"}
        response = self.client.put(f"/api/patients/{patient_id}/", updated_data, format="json")
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data["first_name"], "Jane")

        # Step 4: Delete the Patient
        response = self.client.delete(f"/api/patients/{patient_id}/")
        self.assertEqual(response.status_code, 204)

        # Step 5: Ensure the Patient is Deleted
        response = self.client.get("/api/patients/")
        self.assertEqual(len(response.data), 0)
