import pika
import json
from config import RABBITMQ_HOST, RESPONSE_QUEUE

def send_embedding_result(data: dict):
    connection = pika.BlockingConnection(pika.ConnectionParameters(host=RABBITMQ_HOST))
    channel = connection.channel()
    channel.queue_declare(queue=RESPONSE_QUEUE, durable=True)
    channel.basic_publish(
        exchange='',
        routing_key=RESPONSE_QUEUE,
        body=json.dumps(data)
    )
    connection.close()
