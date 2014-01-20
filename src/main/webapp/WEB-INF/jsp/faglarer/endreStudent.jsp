<%@ page import="no.hist.tdat.javabeans.PersonerBeans" %>
<%@ page import="no.hist.tdat.javabeans.Bruker" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<script>
    function finnRettBruker(mail) {
        if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
            xmlhttp = new XMLHttpRequest();
        }
        else {// code for IE6, IE5
            xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
        }
        xmlhttp.onreadystatechange = function () {

        }
        xmlhttp.open("POST", "endreValgtBruker", true);
        xmlhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
        xmlhttp.send("brukerIndex=" + mail);

        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            //document.getElementById("calendar").innerHTML=xmlhttp.responseText;
            alert("jara");
        }
        window.location = "videresend";
    }
</script>

<div class="col-md-8">

    <h2>Administrer studenter</h2>
    <%--S�kefunksjon etter brukere--%>
    <form:form class="s�kbar" role="search" modelAttribute="personerBeans" action="leggTilStudentListe"
               method="POST">
        <div class="input-group">

            <input type="text" class="form-control" placeholder="S�k" name="soketekst" id="srch-term">

            <div class="input-group-btn">
                <input class="btn btn-success" value="S�k" type="submit"><i class="glyphicon glyphicon-search"></i>
                </input>
            </div>

        </div>
    </form:form>

    <form:form action="videresend">
        <table class="table table-condensed table-hover" id="minTable">
            <thead>
            <tr>
                <th class="header">Fornavn</th>
                <th class="header">Etternavn</th>
                <th class="header">Epost</th>
                <th class="header"></th>
            </tr>
            </thead>

            <tbody>
            <c:forEach var="bruker" items="${personerBeans.valgt}" varStatus="status">
                <tr>
                    <td><c:out value="${bruker.fornavn}"/></td>
                    <td><c:out value="${bruker.etternavn}"/></td>
                    <td><c:out value="${bruker.mail}"/></td>
                    <td>
                        <div class="input-group-btn">
                            <input type="submit" class="btn btn-warning btn-sm" id="${bruker.mail}"
                                    data-toggle="modal" onclick="finnRettBruker(this.id)"
                                    data-target="#endrebrukerModal" value="Endre" title="Endre">
                                <i class="glyphicon glyphicon-edit"></i></input>
                        </div>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </form:form>
</div>