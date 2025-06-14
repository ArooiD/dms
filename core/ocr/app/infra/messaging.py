import pika
import os


def get_rabbitmq_connection():
    rabbitmq_host = os.getenv("RABBITMQ_HOST", "dv.istokmw.tech")
    rabbitmq_port = int(os.getenv("RABBITMQ_PORT", 5672))
    rabbitmq_user = os.getenv("RABBITMQ_USER", "guest")
    rabbitmq_password = os.getenv("RABBITMQ_PASSWORD", "guest")

    credentials = pika.PlainCredentials(rabbitmq_user, rabbitmq_password)
    parameters = pika.ConnectionParameters(
        host=rabbitmq_host,
        port=rabbitmq_port,
        credentials=credentials
    )
    connection = pika.BlockingConnection(parameters)
    return connection


def get_channel(connection):
    return connection.channel()
