<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <title>Venda</title>
        <link rel="stylesheet" href="./css/realizar-venda.css">
        <link rel="stylesheet" href="../css/realizar-venda.css">
        <!--google fonts-->
        <link href="https://fonts.googleapis.com/css?family=Nunito:300,400,700" rel="stylesheet">

        <!--fontawesome-->
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.4.1/css/all.css" integrity="sha384-5sAR7xN1Nv6T6+dT2mhtzEpVJvfS3NScPQTrOxhwjIuvcA67KV2R5Jz6kr4abQsz" crossorigin="anonymous">

        <!--
        <script type="text/javascript">
            function Atualizar(){
                window.location.reload();

                onload="setInterval('Atualizar()', 5000)"
            }
        </script>
        -->

        <!--
        <script>
            function includeHTML() {
              var z, i, elmnt, file, xhttp;
              /*loop through a collection of all HTML elements:*/
              z = document.getElementsByTagName("*");
              for (i = 0; i < z.length; i++) {
                elmnt = z[i];
                /*search for elements with a certain atrribute:*/
                file = elmnt.getAttribute("w3-include-html");
                if (file) {
                  /*make an HTTP request using the attribute value as the file name:*/
                  xhttp = new XMLHttpRequest();
                  xhttp.onreadystatechange = function() {
                    if (this.readyState == 4) {
                      if (this.status == 200) {elmnt.innerHTML = this.responseText;}
                      if (this.status == 404) {elmnt.innerHTML = "Page not found.";}
                      /*remove the attribute, and call this function once more:*/
                      elmnt.removeAttribute("w3-include-html");
                      includeHTML();
                    }
                  }
                  xhttp.open("GET", file, true);
                  xhttp.send();
                  /*exit the function:*/
                  return;
                }
              }
            }
        </script>
        -->

    </head>
    <body>
        <c:if test="${usuario.getId() == null}">
            <c:redirect url="http://localhost:8080/br.com.senac.pi3.pwda/Login?code=00" />
        </c:if>
        <header>
            <nav>
                <div class="top-header">
                    <div class="container">
                        <a href="./jsp/home.jsp">
                            <img class="img-logo" src="../img/pwda-logo.png" alt="" width="200">
                            <img class="img-logo" src="./img/pwda-logo.png" alt="" width="200">
                        </a>
                    </div><!--container-->
                </div><!--logo-->
                <div class="container">
                    <ul class="menu-principal">
                        <li><a href="./jsp/home.jsp">Home</a></li>
                            <c:if test="${usuario.getAutorizar() == 1 || usuario.getAutorizar() == 2}">
                            <li class="link-submenu-cadastro"><a href="#">Cadastro</a>
                                <ul class="sub-menu">
                                    <c:if test="${usuario.getAutorizar() == 2}">
                                        <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/EmpCadastrar" method="get">Empresa</a></li>
                                        </c:if>
                                    <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/CliCadastrar" method="get">Cliente</a></li>
                                    <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/FuncCadastrar" method="get">Funcionário</a></li>
                                    <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/ProdCadastrar" method="get">Produto</a></li>
                                </ul>
                            </li>
                            <li class="link-submenu-consulta"><a href="#">Consultar</a>
                                <ul class="sub-menu">
                                    <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/EmpConsultar" method="get">Empresa</a></li>
                                    <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/CliConsultar" method="get">Cliente</a></li>
                                    <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/FuncConsultar" method="get">Funcionário</a></li>
                                    <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/ProdConsultar" method="get">Produto</a></li>
                                </ul>
                            </li>
                            <li class="link-submenu-consulta"><a href="#">Relatórios</a>
                                <ul class="sub-menu">
                                    <c:if test="${usuario.getAutorizar() == 2}">
                                        <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/Relatorio-Global" method="get">Relatório Global</a></li>
                                        </c:if>
                                    <li class="sub-menu-item"><a href="${pageContext.request.contextPath}/Relatorio-Regional" method="get">Relatório Regional</a></li>
                                </ul>
                            </li>
                        </c:if>
                        <li><a href="${pageContext.request.contextPath}/Caixa">Realizar Venda</a></li>
                        <li><a href="${pageContext.request.contextPath}/logout">Sair</a></li>
                    </ul>
                </div><!--container-->
            </nav>
        </header>
        <section class="venda">
            <div class="container">
                <div class="aside">
                    <h2 class="chamada-venda">Agora é a hora de realizar a venda!</h2>
                    <div class="container-venda">
                        <form method="post">
                            
                            <c:if test="${produto.getImagem() != null}" >
                                <input style="width: 150px; height: 150px; position: absolute; top: 150px; right: 13%; background: rgba(0,0,0,.1);" type="image" id="image-produto" alt="Imagem do produto"
                                   src="img/produtos/${produto.getImagem()}">
                            </c:if>
                                
                            <c:if test="${produto.getImagem() == null}" >
                                <input style="width: 150px; height: 150px; position: absolute; top: 150px; right: 13%; background: rgba(0,0,0,.1);" type="image" id="image-produto" alt="Imagem do produto"
                                   src="img/produtos/sem-imagem.png">
                            </c:if>
                            
                            
                            CPF<input type="text" name="cpf" placeholder="Digite o CPF/CNPJ para buscar" value="${cliente.getNumDocumento()}">
                            Nome<input type="text" id="nome-cliente" class="nome-cliente" name="nomeCli" placeholder="Nome do Cliente" value="${cliente.getNome()}" readonly="true">
                            <input type="submit" name="btnCli" value="Buscar Cliente" formaction="CarregarCli"><br>

                            <input type="hidden" name="id" value="${produto.getId()}" >
                            Nome<input type="text" name="vendaProduto" placeholder = "Produto..." value="${produto.getProduto()}" value="${buscar}" >
                            Valor Unitário<input type="text" name="valorUnitario" value="${produto.getValorUnitario()}" readonly="true">
                            Qtd<input type="number" name="quantidadeVenda" placeholder="Quantidade..." min="1">
                            <input type="submit" name="btnCarregar" value="Carregar Produto" formaction="CarregarProd">
                            <input type="submit" name="btnIncluir" value="Incluir" formaction="IncluirProd" > <br>

                            <c:out value="${msgErro}"/> <br>
                        </form>

                        <div class="listar-venda">

                            <table>
                                <tr>
                                    <th>Cód Produto</th>
                                    <th>Quantidade</th>
                                    <th>Produto</th>
                                    <th>Valor unitário</th>
                                    <th>Valor total</th>
                                    <th>Deletar</th>
                                </tr>

                                <c:forEach items="${listaProduto}" var="prod" varStatus="stat">
                                    <tr>
                                        <td> <c:out value="${prod.getId()}"/> </td>
                                        <td> <c:out value="${prod.getQtdProd()}"/> </td>
                                        <td> <c:out value="${prod.getProduto()}"/> </td>
                                        <td> <c:out value="${prod.getValorUnitario()}"/> </td>
                                        <td> <c:out value="${prod.getValorTotal()}"/> </td>

                                        <td>
                                            <a href="DeleteVenda?id=<c:out value='${prod.getId()}'/>"
                                               class="btn-delete"> <i class="fas fa-times"> </i> </a>
                                        </td>
                                    </tr>
                                </c:forEach>


                            </table>

                        </div><!--listar-venda-->
                        <form class="confirmar" action="${pageContext.request.contextPath}/RealizarVenda" method="post">
                            <input type="hidden" name="idCaixa" value="${usuario.getId()}">
                            <input type="hidden" name="idCliente" value="${cliente.getId()}" >
                            <label for="">SUBTOTAL:</label>
                            <input class="campo-subtotal" id="sub-total" type="text" name="sub-total" value="${subtotal}" readonly="true">                            
                            <input onclick="confirmar()" type="button" name="btn-subtotal" class="btnFecharCompra" value="Fechar Compra">
                            
                            <div id="modal-venda" class="modal-container">
                                <div class="modal">
                                    <a class="fechar"> <p class="fechar-in"> x </p> </a>
                                    <h3 class="subtitulo">Confirmação de Venda</h3>
                                    <form>
                                        <label for="cliente">Cliente</label>
                                        <input type="text" class="cliente" name="cliente" id="cliente" readonly="true"> <br>
                                        <label for="cliente">Total</label> 
                                        <input type="text" class="total" name="total" id="total" readonly="true"> <br> 
                                        <input type="submit" class="confirmarVenda" value="Confirmar Venda">
                                    </form>                                    
                                </div>
                            </div>
                            
                        </form>
                    </div><!--container-venda-->
                </div>
            </div><!--container-->
        </section><!--venda-->

        <style>
            .modal-container{
                width: 100vw;
                height: 100vh;
                background: rgba(0,0,0,.5);
                position: fixed;
                top: 0px;
                left: 0px;
                z-index: 2000;
                display: none;
                justify-content: center;
                align-items: center;
            }        

            .modal-container.mostrar{
                display: flex;

            }

            .modal{
                background: white;
                width: 50%;
                min-width: 300px;
                padding: 80px;
                border: 10px solid #42f4a1;
                box-shadow: 0 0 0 10px white;
                position: relative;

            }

            @keyframes modalAnime{
                from{
                    opacity: 0;
                    transform: translate3d(0, -80px , 0);
                }
                to{
                    opacity: 1;
                    transform: translate3d(0, 0 , 0);
                }
            }

            .mostrar .modal{
                animation: modalAnime .3s;
            }
            
            .fechar p{
                        top: 50%;
                        left: 50%;
                        transform: translate(-30%, -55%);
                        position: relative;
                        font-size: 50px;
                        color: white;
                        font-weight: bold;
            }
            
            .fechar{
               position: absolute;
                top: -30px;
                right: -30px;
                width: 50px;
                height: 50px;
                border-radius: 50%;
                border: 4px solid white;
                background: #42f4a1;
                color: white;
                font-size: 40px;
                font-family: "PT Mono", monospace;
                cursor: pointer;
                box-shadow: 0 4px 0 rgba(0, 0, 0, .3);
            }

            .confirmarVenda{
                margin: 5vh 2vw 2vh 0;
                width: 150px!important;
                background: #42b3f4;
                cursor: pointer;
                color: white;
            }

        </style>

        <script>
            function iniciaModal(modalID) {
                const modal = document.getElementById(modalID);
                if (modal) {
                    modal.classList.add('mostrar');
                    modal.addEventListener('click', (e) => {
                        if (e.target.className == 'fechar-in') {
                            modal.classList.remove('mostrar');
                        }
                    });
                }
            }

            const venda = document.querySelector('.btnFecharCompra');
            venda.addEventListener('click', () => iniciaModal('modal-venda'));

        </script>        
 
        <script type="text/javascript">            
            function confirmar() {
                var total = document.getElementById('sub-total').value;
                var cliente = document.getElementById('nome-cliente').value;                
                document.querySelector('.cliente').value = cliente;
                document.querySelector('.total').value = total;
            }
        </script>
    </body>
</html>
