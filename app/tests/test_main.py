import json
from app.main import app

def test_health():
    client = app.test_client()
    response = client.get("/health")
    assert response.status_code == 200
    assert response.get_json() == {"status": "UP"}

def test_predict():
    client = app.test_client()
    payload = {"feature1": 10, "feature2": 20}
    response = client.post("/predict", data=json.dumps(payload), content_type="application/json")
    assert response.status_code == 200
    assert response.get_json()["prediction"] == "class_A"
