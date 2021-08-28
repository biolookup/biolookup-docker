FROM python:3.9

RUN python -m pip install --upgrade pip
RUN python -m pip install gunicorn
# Uncomment if you want to get the latest eversion
RUN python -m pip install "pyobo[web,database]>=0.6.2"
#RUN python -m pip install git+https://github.com/pyobo/pyobo.git#egg=pyobo[web,database]
ENTRYPOINT biolookup --port 8765 --host "0.0.0.0" --sql --with-gunicorn --workers 4
