# Clean Swift - VIP

O VIP é um padrão de design baseado no livro *Clean Architecture* de *Uncle Bob*, criado com o intuito de dividir as responsabilidades dadas as ViewControllers, sendo uma alternativa para a solução do problema de ViewControllers massivas.

Nessa estrutura cada contexto de tela pode ser entendida como uma cena (scene), que é formada pela ViewController, Interactor e Presenter, assim como outros elementos como Models, Workers (Repository ou Service) e ViewModels.

## VIP Cycle

O ciclo VIP da-se pela ligação dos elementos principais **ViewController**, **Interactor** e **Presenter** que, através de protocolos, formam um canal unidirecional dos dados conhecido como VIP Cycle.

![alt text](https://res.cloudinary.com/practicaldev/image/fetch/s--xT9M9YoH--/c_limit%2Cf_auto%2Cfl_progressive%2Cq_auto%2Cw_880/https://needone.app/content/images/2020/10/image-1.png)

### ViewController

Responsável pela interação com usuários através dos elementos de tela (Clique de botão, caixa de textos, etc.), a renderização da informação enviada pela **Presenter** e as requisições feitas ao **Interactor**.

### Interactor

Responsável pelo processamento da cena como chamadas à API, validações e cálculos. Para isso conta com a estrutura de **Workers**, que são componentes responsáveis pela a comunicação com outras estruturas (API, Frameworks).

### Presenter

Trata as respostas do Interactor e estrutura como será renderizada na **ViewController** por meio de **ViewModels**.
