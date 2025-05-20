import os

def submitits_addons():
    print("SUS ASSHOLE")
    base_dir = os.environ["WORK"] + "/sync/sam2"
    data_dir = os.environ["TMPDIR"]
    print(base_dir)
    print(data_dir)
    tmpdir = os.environ.get("TMPDIR", "/tmp")  # Fallback for non-SLURM environments
    data_dir = tmpdir
    print(data_dir)
