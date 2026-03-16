# ─────────────────────────────────────────────────────────
# Retail Sales & Customer Behavior Analytics Pipeline
# Author: Dipak Ghadge
# Description: End-to-end synthetic retail data generation,
# cleaning, KPI calculation, and visualization.
# ─────────────────────────────────────────────────────────
def log_step(message):
    """Utility function for consistent logging."""
    print(f"[INFO] {message}")
    
    print("✅ Output folders ready")
    
    log_step("Output folders created successfully")
    
    log_step("Output folders created successfully")
    
    N = 10000
    
    # Configurable dataset size
DATASET_SIZE = 10000
N = DATASET_SIZE

def validate_dataset(df):
    """Basic validation checks for generated dataset."""
    if df.empty:
        raise ValueError("Dataset generation failed: DataFrame is empty")
    if 'order_id' not in df.columns:
        raise ValueError("Missing critical column: order_id")
    
    df = pd.DataFrame({
        
        validate_dataset(df)