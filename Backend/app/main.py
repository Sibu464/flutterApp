
from fastapi import FastAPI,HTTPException,Depends
from pydantic import BaseModel
from typing import List, Annotated
from starlette.middleware.cors import CORSMiddleware
from . import models
import numpy as np
from .database import SessionLocal,engine
from sqlalchemy.orm import Session
from . models import SawtoothWave

app = FastAPI()
models.Base.metadata.create_all(bind=engine)
# origins = ["http://localhost:63599",] #Flutter port

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],#For Testing
    allow_credentials=True,
    allow_methods=["*"],  # Allows all HTTP methods (GET, POST, PUT, DELETE)
    allow_headers=["*"],  # Allows all headers
)

def get_db():
    db=SessionLocal()
    try:
        yield db
    finally:
        db.close()

db_dependency=Annotated[Session,Depends(get_db)]

frequency = 0.1
duration = 10
sampling_rate = 2

def generate_sawtooth_wave():
    t = np.linspace(0, duration, int(duration * sampling_rate), endpoint=False)
    sawtooth_wave = 2 * (t * frequency - np.floor(0.5 + t * frequency))
    t = np.append(t, duration)
    sawtooth_wave = np.append(sawtooth_wave, 0.0)
    return [{"timestamp": round(time, 3), "amplitude": round(value, 6)} for time, value in zip(t, sawtooth_wave)]

@app.post("/generate")
async def save_sawtooth_wave(db: Session = Depends(get_db)):
    data = generate_sawtooth_wave()
    #TODO fix
    db.bulk_save_objects([
        SawtoothWave(timestamp=float(point["timestamp"]), amplitude=float(point["amplitude"]))
        for point in data
    ])
    db.commit()
    return {"message": "Sawtooth wave data saved successfully!"}



#TODO Move endpoints to routes and crud operations to crud file
@app.get("/sawtooth/next3/{index}")
def get_next_sawtooth_wave(index: int, db: Session = Depends(get_db)):
    data = db.query(SawtoothWave).order_by(SawtoothWave.timestamp).offset(index).limit(3).all()
    if not data:
        raise HTTPException(status_code=404, detail="No more data available")

    return [{"timestamp": record.timestamp, "amplitude": record.amplitude} for record in data]