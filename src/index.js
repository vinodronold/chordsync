import './styles/main.css'
import { Main } from './Main.elm'
import registerServiceWorker from './registerServiceWorker'

import { MDCMenu } from '@material/menu/dist/mdc.menu'

var app = Main.embed(document.getElementById('root'))

registerServiceWorker()

var menu

app.ports.elmData.subscribe(({ tag, data }) => {
  switch (tag) {
    case 'MenuClick':
      if (!menu) {
        menu = new MDCMenu(document.querySelector('#MenuOption'))
      }
      menu.open = true
  }
})
