from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime

# Item Models
class ItemBase(BaseModel):
    name: str = Field(..., min_length=1, max_length=100)
    description: Optional[str] = Field(None, max_length=500)
    quantity: int = Field(..., ge=0)
    price: float = Field(..., ge=0)
    category: Optional[str] = Field(None, max_length=50)

class ItemCreate(ItemBase):
    pass

class ItemUpdate(ItemBase):
    name: Optional[str] = Field(None, min_length=1, max_length=100)
    quantity: Optional[int] = Field(None, ge=0)
    price: Optional[float] = Field(None, ge=0)

class ItemResponse(ItemBase):
    id: int
    created_at: datetime
    updated_at: datetime
    user_id: str

    class Config:
        from_attributes = True

# User Models
class UserResponse(BaseModel):
    id: str
    email: str
    created_at: datetime
    
    class Config:
        from_attributes = True

# General Response Models
class Message(BaseModel):
    message: str

class ErrorResponse(BaseModel):
    error: str
    detail: Optional[str] = None
