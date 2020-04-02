import './vendor/bootstrap'
import 'unpoly/dist/unpoly'

up.compiler('body', () => {
    $('html').removeClass('no-js')
})
