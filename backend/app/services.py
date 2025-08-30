from typing import List, Optional, Dict, Any
from fastapi import HTTPException, status
from app.database import supabase
from app.models import ItemCreate, ItemUpdate, ItemResponse

class ItemService:
    @staticmethod
    async def create_item(item_data: ItemCreate, user: Dict[str, Any]) -> ItemResponse:
        """Create a new inventory item for the authenticated user."""
        try:
            # Convert Pydantic model to dict
            item_dict = item_data.model_dump()
            item_dict['user_id'] = user.id
            
            # Insert item into Supabase
            result = supabase.table('items').insert(item_dict).execute()
            
            if not result.data:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="Failed to create item"
                )
            
            return ItemResponse(**result.data[0])
            
        except Exception as e:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Error creating item: {str(e)}"
            )
    
    @staticmethod
    async def get_user_items(user: Dict[str, Any]) -> List[ItemResponse]:
        """Get all items for the authenticated user."""
        try:
            result = supabase.table('items').select('*').eq('user_id', user.id).execute()
            
            if not result.data:
                return []
            
            return [ItemResponse(**item) for item in result.data]
            
        except Exception as e:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Error fetching items: {str(e)}"
            )
    
    @staticmethod
    async def get_item_by_id(item_id: int, user: Dict[str, Any]) -> ItemResponse:
        """Get a specific item by ID for the authenticated user."""
        try:
            result = supabase.table('items').select('*').eq('id', item_id).eq('user_id', user.id).execute()
            
            if not result.data:
                raise HTTPException(
                    status_code=status.HTTP_404_NOT_FOUND,
                    detail="Item not found"
                )
            
            return ItemResponse(**result.data[0])
            
        except HTTPException:
            raise
        except Exception as e:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Error fetching item: {str(e)}"
            )
    
    @staticmethod
    async def update_item(item_id: int, item_data: ItemUpdate, user: Dict[str, Any]) -> ItemResponse:
        """Update an existing item for the authenticated user."""
        try:
            # First check if item exists and belongs to user
            await ItemService.get_item_by_id(item_id, user)
            
            # Convert to dict and remove None values
            update_dict = {k: v for k, v in item_data.model_dump().items() if v is not None}
            
            if not update_dict:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="No valid fields to update"
                )
            
            # Update item
            result = supabase.table('items').update(update_dict).eq('id', item_id).eq('user_id', user.id).execute()
            
            if not result.data:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="Failed to update item"
                )
            
            return ItemResponse(**result.data[0])
            
        except HTTPException:
            raise
        except Exception as e:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Error updating item: {str(e)}"
            )
    
    @staticmethod
    async def delete_item(item_id: int, user: Dict[str, Any]) -> dict:
        """Delete an item for the authenticated user."""
        try:
            # First check if item exists and belongs to user
            await ItemService.get_item_by_id(item_id, user)
            
            # Delete item
            result = supabase.table('items').delete().eq('id', item_id).eq('user_id', user.id).execute()
            
            return {"message": "Item deleted successfully"}
            
        except HTTPException:
            raise
        except Exception as e:
            raise HTTPException(
                status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
                detail=f"Error deleting item: {str(e)}"
            )
