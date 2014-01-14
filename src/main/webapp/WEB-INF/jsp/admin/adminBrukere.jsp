<div class="col-md-8">
    <h2>Administrer brukere</h2>

    <form class="søkbar" role="search">
        <div class="input-group">

            <input type="text" class="form-control" placeholder="Søk" name="srch-term" id="srch-term">

            <div class="input-group-btn">
                <button class="btn btn-success" type="submit"><i class="glyphicon glyphicon-search"></i></button>
            </div>

        </div>
    </form>
    <div class="span5">
        <table class="table table-hover" id="minTable">
            <thead>
            <tr>
                <th class="header">Fornavn</th>
                <th class="header">Etternavn</th>
                <th class="header">Epost</th>
                <th class="header">Rettighet</th>
                <th class="header">Opprettet</th>
                <th class="header">Status</th>
                <th class="header"></th>
            </tr>
            </thead>

            <tbody>

            <tr>
                <td>Olve</td>
                <td>Børmark</td>
                <td>oabormar@stud.hist.no</td>
                <td>Student</td>
                <td>2012/08/16</td>
                <td><span class="btn btn-success btn-sm active">Aktiv</span></td>
                <td>
                    <div class="input-group-btn">
                        <button type="edit" class="btn btn-warning btn-sm" data-toggle="modal"
                                data-target="#endrebrukerModal" title="Endre">
                            <i class="glyphicon glyphicon-edit"></i></button>
                        <button type="remove" class="btn btn-danger btn-sm" data-task="remove" title="Fjern"
                                onclick="slettBruker()" id="removeknapp"><i class="glyphicon glyphicon-remove"></i>
                        </button>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>


    <form method="POST" modelAttribute="leggTilBruker" action="leggtilbruker.html">
        <h2>
            <div id="operasjonstekst">
                Legg til bruker
            </div>
        </h2>
        <div class="form-group">
            <label for="fornavn">Fornavn</label>

            <input path="fornavn" id="fornavn" class="form-control"/>

            <errors path="fornavn"/>
        </div>
        <div class="form-group">
            <label for="etternavn">Etternavn:</label>

            <input id="etternavn" path="etternavn" class="form-control"/>

            <errors path="etternavn"/>
        </div>


        <div class="form-group">
            <label for="epost">Epost</label>

            <input id="epost" path="epost" class="form-control"/>

            <errors path="epost"/>
        </div>
        <div class="form-group">
            <label>Passord:</label>

            <input path="passord" class="form-control"/>

            <errors path="passord"/>
        </div>

        <div class="form-group">
            <label for="rettigheter">Rettigheter</label>
            <select id="rettigheter" class="form-control">
                <option value="ingen"><i>Ingen valgt</i></option>
                <option value="admin">Admin</option>
                <option value="lærer">L&aeligrer</option>
                <option value="studentassistent">Studentassistent</option>
                <option value="student">Student</option>
            </select>
        </div>
        <button type="button" class="btn btn-primary btn-block">
            <div id="leggtilknapp">Legg til</div>
        </button>
    </form>
    <br>


    <form method="POST" modelAttribute="lesInnFil" action="leggTilFil.html" id="lesInnFil">
        <div id="leggTilFilText">
            <h2> Legg til flere brukere via fil </h2>
        </div>

        <input type="text" id="text" path="text"/>

        <input type="file" id="files" name="files[]" multiple />
        <output id="list"></output>

        <script>
            function handleFileSelect(evt) {
                var files = evt.target.files; // FileList object
                var leser = new FileReader;
                var text = document.getElementById('text');

                // files is a FileList of File objects. List some properties.
                var output = [];
                for (var i = 0, f; f = files[i]; i++) {
                    output.push('<li><strong>', escape(f.name), '</strong> (', f.type || 'n/a', ') - ',
                            f.size, ' bytes, last modified: ',
                            f.lastModifiedDate ? f.lastModifiedDate.toLocaleDateString() : 'n/a','</li>');

                }
                leser.readAsText(files);
                document.getElementById('list').innerHTML = '<ul>' + output.join('') + '</ul>';

            }
            document.getElementById('files').addEventListener('change', handleFileSelect, false);

        </script>
        <br>
        <button type="button" class="btn btn-primary btn-block">Last opp fil</button>
        <input type="submit" value="send">
    </form>

    <div class="modal fade" id="endrebrukerModal" tabindex="-1" role="dialog" aria-labelledby="endrebrukerLabel"
         aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h2 class="modal-title" id="velgøvingLabel">Endre Bruker</h2>
                </div>
                <div class="modal-body">
                    <form method="POST" modelAttribute="leggTilBruker" action="leggtilbruker.html">
                        <div class="form-group">
                            <label for="endrefornavn">Fornavn</label>

                            <input path="endrefornavn" id="endretfornavn" class="form-control"/>

                            <errors path="fornavn"/>
                        </div>
                        <div class="form-group">
                            <label for="endreetternavn">Etternavn:</label>

                            <input id="endreetternavn" path="etternavn" class="form-control"/>

                            <errors path="etternavn"/>
                        </div>

                        <fieldset disabled>
                            <div class="form-group">
                                <label for="endreepost">Epost</label>

                                <input id="endreepost" path="epost" class="form-control"/>

                                <errors path="epost"/>
                            </div>
                            <div class="form-group">
                                <label>Passord:</label>

                                <input path="passord" class="form-control"/>

                                <errors path="passord"/>
                            </div>
                        </fieldset>

                        <div class="form-group">
                            <label for="endrerettigheter">Rettigheter</label>
                            <select id="endrerettigheter" class="form-control">
                                <option value="ingen"><i>Ingen valgt</i></option>
                                <option value="admin">Admin</option>
                                <option value="lærer">L&aeligrer</option>
                                <option value="studentassistent">Studentassistent</option>
                                <option value="student">Student</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="endrestatus">Status</label>
                            <select id="endrestatus" class="form-control">
                                <option value="ingen"><i>Aktiv</i></option>
                                <option value="admin">Inaktiv</option>
                            </select>
                        </div>
                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Lukk</button>
                    <button type="button" class="btn btn-primary">Lagre</button>
                </div>
            </div>
        </div>
    </div>
</div>