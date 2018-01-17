FROM python:3.6.4-alpine3.7

WORKDIR /app

ARG requirements=requirements.txt

COPY requirements requirements/
COPY requirements.txt manage.py /app/
RUN pip install -r $requirements

COPY conf conf/
COPY project project/

EXPOSE 8000

CMD ["python", "manage.py", "runserver"]
