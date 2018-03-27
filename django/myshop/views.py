import uuid

from django import forms
from django.shortcuts import render
from futupayments.forms import PaymentForm, RecieptItem


class Product:
    def __init__(self, id, name, price_rub):
        self.id = id
        self.name = name
        self.price_rub = price_rub

    def __str__(self):
        return '{} ({} руб.)'.format(self.name, self.price_rub)


products = (
    Product(1, 'Слон индийский', 200),
    Product(2, 'Слон африканский', 250),
)
products_by_id = {p.id: p for p in products}


def index(request):
    order_form = OrderForm(request.POST or None, initial={
        'email': 'maxim.oransky@gmail.com',
        'order_id': str(uuid.uuid4()),
        'product_id': products[0].id,
    })
    payment_form = None
    if request.method == 'POST':
        if order_form.is_valid():
            data = order_form.cleaned_data
            product = products_by_id[int(data['product_id'])]
            payment_form = PaymentForm.create(
                request,
                amount=product.price_rub * data['n'],
                order_id=data['order_id'],
                description='Заказ №{}'.format(data['order_id']),
                receipt_contact=data['email'],
                receipt_items=[
                    RecieptItem(product.name, product.price_rub, n=data['n']),
                ],
                cancel_url=request.build_absolute_uri('/django/'),
            )
            assert payment_form.is_valid()
    return render(request, 'index.html', {
        'products': products,
        'payment_form': payment_form,
        'order_form': order_form,
    })


class OrderForm(forms.Form):
    order_id = forms.CharField(widget=forms.HiddenInput)
    email = forms.EmailField(label='Email (для чека)')
    product_id = forms.ChoiceField(
        label='товар',
        choices=[(p.id, str(p)) for p in products],
        widget=forms.Select(),
    )
    n = forms.IntegerField(min_value=1, max_value=100, initial=2,
                           label='количество, шт.')
