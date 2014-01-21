<%--
  Created by IntelliJ IDEA.
  User: Thomas
  Date: 13.01.14
  Time: 15:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<div class="col-md-6">
    <h2>Godkjenn øvinger</h2>
    <form:form class="sok" role="search" modelAttribute="godkjennOving" action="sok.htm" method="POST">
        <div class="form-group">
            <label for="mail">Mail</label>

            <form:input path="mail" id="mail" class="form-control"/>

            <form:errors path="mail"/>
        </div>
        <div class="form-group">
            <label for="koeID">koe_id</label>

            <form:input path="koeID" id="koeID" class="form-control"/>

            <form:errors path="koeID<"/>
        </div>
        <div class="form-group">
            <label for="koePlass">Koe Plass</label>

            <form:input path="koePlass" id="koePlass" class="form-control"/>

            <form:errors path="koePlass<"/>
        </div>

        <table class="table table-condensed" id="godkjennGruppe">
            <tbody>
                <tr>
                    <td><c:out value="${koegrupper}"/></td>
                    <td><c:out value="${koeGrupper.ovingsnummer}"/>/td>
                    <td><c:out value="${koeGrupper.mail}"/>/td>
                    <td><c:out value="${koeGrupper.koePlass}"/></td>
                </tr>
            </tbody>
        </table>
    </form:form>

</div>
<script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
<script src="<c:url value="/resources/js/jquery-1.10.2.js"/>"></script>
