import asyncio
import logging
import sys

try:
    from amqtt.broker import Broker
except ImportError:
    sys.stderr.write('ERROR: You need to have `amqtt` installed to run this script (`pip install amqtt`).')
    exit(1)


async def broker_coro():
    config = {
        'listeners': {
            'default': {
                'max_connections': 100,
                'type': 'tcp'
            },
            'beamng-tcp': {
                'bind': '127.0.0.1:1883'
            }
        },
        'timeout-disconnect-delay': 2
    }
    broker = Broker(config)
    await broker.start()


if __name__ == '__main__':
    formatter = "[%(asctime)s] :: %(levelname)s :: %(name)s :: %(message)s"
    logging.basicConfig(level=logging.DEBUG, format=formatter)
    asyncio.get_event_loop().run_until_complete(broker_coro())
    asyncio.get_event_loop().run_forever()
