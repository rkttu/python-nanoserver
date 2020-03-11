FROM rkttu/python-nanoserver:3.7.4_1809

EXPOSE 8000
RUN pip install django

WORKDIR C:\\website
ADD . .

ENV DJANGO_DEBUG=1
CMD python -Wall manage.py runserver --insecure 0.0.0.0:8000
