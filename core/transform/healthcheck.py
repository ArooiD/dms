import httpx

def check_service_health(url: str = "http://localhost:8000/health"):
    try:
        response = httpx.get(url, timeout=3.0)
        if response.status_code == 200 and response.json().get("status") == "ok":
            print("✅ Service is healthy.")
            return True
        else:
            print("❌ Service returned unhealthy status.")
            return False
    except httpx.RequestError as e:
        print(f"❌ Request failed: {e}")
        return False

if __name__ == "__main__":
    check_service_health()
