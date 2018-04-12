#!/usr/bin/env python3
import base64
import hashlib
import click
import requests


@click.command()
@click.argument('callback_url')
@click.argument('order_id')
@click.argument('amount')
@click.option('--currency', default='RUB')
@click.option('--merchant_secret_key', default='F87939421C1826BF920927395C61BA2C')  # noqa
def main(
    callback_url,
    order_id,
    amount,
    currency,
    merchant_secret_key,
):
    data = {
        'order_id': order_id,
        'currency': currency,
        'amount': amount,
        'testing': '1',
        'state': 'COMPLETE',
    }
    data['signature'] = get_signature(merchant_secret_key, data)
    result = requests.post(callback_url, data=data)
    print('status: %r' % result.status_code)
    assert result.status_code == 200
    print('result: %r' % result.text)
    assert result.text.startswith('OK{}'.format(order_id))


def get_signature(secret_key: str, params: dict) -> str:
    return double_sha1(secret_key, '&'.join(
        '='.join((k, base64.b64encode(str(params[k]).encode()).decode()))
        for k in sorted(params)
        if params[k] and k != 'signature'
    ))


def double_sha1(secret_key: str, s: str) -> str:
    secret_key = secret_key.encode()
    for i in range(2):
        s = s.encode()
        s = hashlib.sha1(secret_key + s).hexdigest()
    return s


if __name__ == '__main__':
    main()

