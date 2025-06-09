import pika
import json
from embedding import generate_embedding
from rabbitmq_producer import send_embedding_result
from app.config.settings import RABBITMQ_HOST, REQUEST_QUEUE
import logging

def on_request(ch, method, properties, body):
    data = json.loads(body)
    text = data.get('text')
    if not text:
        logging.error('No text found in message')
        ch.basic_ack(delivery_tag=method.delivery_tag)
        return

    embedding = generate_embedding(text)

    response = {
        'text': text,
        'embedding': embedding
    }

    send_embedding_result(response)
    ch.basic_ack(delivery_tag=method.delivery_tag)

def consume():
    connection = pika.BlockingConnection(pika.ConnectionParameters(host=RABBITMQ_HOST))
    channel = connection.channel()
    channel.queue_declare(queue=REQUEST_QUEUE, durable=True)
    channel.basic_qos(prefetch_count=1)
    channel.basic_consume(queue=REQUEST_QUEUE, on_message_callback=on_request)
    logging.info("Waiting for messages. To exit press CTRL+C")
    channel.start_consuming()
