FROM python:3.6.4-alpine3.7

WORKDIR /app

RUN apk --no-cache add imagemagick zlib-dev jpeg-dev gcc build-base postgresql-dev

ARG requirements=requirements.txt

COPY requirements requirements/
COPY requirements.txt manage.py /app/
RUN pip install --no-cache -r $requirements

COPY conf conf/
COPY project project/

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
