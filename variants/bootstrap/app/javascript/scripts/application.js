import 'unpoly/unpoly.min'
import 'unpoly/unpoly-bootstrap5.min'

up.compiler('body', () => {
    $('html').removeClass('no-js')
})
