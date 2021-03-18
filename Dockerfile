FROM python:3.8

RUN python -m pip install --upgrade pip
RUN python -m pip install gunicorn
RUN python -m pip install git+https://github.com/pyobo/pyobo.git#egg=pyobo[web,database]
ENTRYPOINT pyobo apps resolver --port 8765 --host "0.0.0.0" --sql --with-gunicorn --workers 4
