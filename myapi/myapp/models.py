from django.db import models

# Create your models here.

class Music (models.Model):

    class Meta:

        db_table = 'music'

    title = models.CharField(max_length=200)
    seconds = models.IntegerField()
    data = models.IntegerField()
    componente = models.CharField(max_length=200)
    versao = models.BooleanField()
    responsavel = models.CharField(max_length=200)
    status = models.CharField(max_length=200)

    def __str__(self):
        return self.title

