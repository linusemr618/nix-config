python -m venv .venv --copies --system-site-packages
source .venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt
deactivate