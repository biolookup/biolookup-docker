FROM python:3.8

RUN python -m pip install --upgrade pip
RUN python -m pip install gunicorn
RUN python -m pip install git+https://github.com/pyobo/pyobo.git[web,database]
