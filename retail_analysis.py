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
        
        import time
start_time = time.time()

end_time = time.time()
print(f"[INFO] Total execution time: {round(end_time - start_time, 2)} seconds")
quality_report = {
    "missing_values": df_clean.isnull().sum().to_dict(),
    "duplicate_rows": int(df.duplicated().sum()),
    "final_rows": int(len(df_clean))
}

with open("outputs/data_quality_report.json", "w") as f:
    json.dump(quality_report, f, indent=2)