def predict_risk(rainfall: float, humidity: float) -> str:
    """Simple prototype risk function. Replace with ML model later."""
    try:
        r = float(rainfall)
        h = float(humidity)
    except Exception:
        return 'Low'
    if r > 80 and h > 70:
        return 'High'
    if r > 50:
        return 'Moderate'
    return 'Low'
