from sqlalchemy import Boolean,Column,ForeignKey,Integer,String,Float
from .database import Base

class SawtoothWave(Base):
    __tablename__ = "sawtooth_wave"
    id = Column(Integer, primary_key=True, index=True)
    timestamp = Column(Float, nullable=False)
    amplitude = Column(Float, nullable=False)

