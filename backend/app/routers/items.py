from fastapi import APIRouter, Depends, HTTPException, status
from typing import List, Dict, Any
from app.models import ItemCreate, ItemUpdate, ItemResponse, Message
from app.services import ItemService
from app.auth import get_current_user

router = APIRouter(prefix="/items", tags=["items"])

@router.post("/", response_model=ItemResponse, status_code=status.HTTP_201_CREATED)
async def create_item(
    item_data: ItemCreate,
    current_user: Dict[str, Any] = Depends(get_current_user)
):
    """
    Create a new inventory item.
    """
    return await ItemService.create_item(item_data, current_user)

@router.get("/", response_model=List[ItemResponse])
async def get_items(
    current_user: Dict[str, Any] = Depends(get_current_user)
):
    """
    Get all inventory items for the authenticated user.
    """
    return await ItemService.get_user_items(current_user)

@router.get("/{item_id}", response_model=ItemResponse)
async def get_item(
    item_id: int,
    current_user: Dict[str, Any] = Depends(get_current_user)
):
    """
    Get a specific inventory item by ID.
    """
    return await ItemService.get_item_by_id(item_id, current_user)

@router.put("/{item_id}", response_model=ItemResponse)
async def update_item(
    item_id: int,
    item_data: ItemUpdate,
    current_user: Dict[str, Any] = Depends(get_current_user)
):
    """
    Update an existing inventory item.
    """
    return await ItemService.update_item(item_id, item_data, current_user)

@router.delete("/{item_id}", response_model=Message)
async def delete_item(
    item_id: int,
    current_user: Dict[str, Any] = Depends(get_current_user)
):
    """
    Delete an inventory item.
    """
    result = await ItemService.delete_item(item_id, current_user)
    return Message(**result)
