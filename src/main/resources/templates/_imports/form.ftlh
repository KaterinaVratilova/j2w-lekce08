[#ftl]

[#macro form method bind attributes...]
    [#assign bind = .data_model[bind] ]
    [#assign bindStatus = .data_model["org.springframework.validation.BindingResult.${bind}"] ]
    <form class="row g-3 ${bindStatus.hasFieldErrors('*')?string('was-validated', '')}" method="${method}" novalidate [@attrs attributes /]>
        [#nested ]
    </form>
[/#macro]

[#macro input name label type="text" attributes...]
    <label for="${name}" class="form-label">${label}</label>
    <input type="${type}" class="form-control ${bindStatus.hasFieldErrors(name)?string('is-invalid', 'is-valid')}" id="${name}" name="${name}" value="${bind[name]!}" [@attrs attributes /]>
    [@errors name=name /]
[/#macro]

[#macro inputDate name label attributes...]
    <label for="${name}" class="form-label">${label}</label>
    <input type="date" class="form-control ${bindStatus.hasFieldErrors(name)?string('is-invalid', 'is-valid')}" id="${name}" name="${name}" value="${(bind[name]?date?iso_local)!}" [@attrs attributes /]>
    [@errors name=name /]
[/#macro]

[#macro errors name]
    [#if bindStatus.hasFieldErrors(name)]
        <ul  class="invalid-feedback">
        [#list bindStatus.getFieldErrors(name) as error]
            <li>${error.defaultMessage}</li>
        [/#list]
        </ul>
    [/#if]
[/#macro]

[#macro attrs attributes]
    [#list attributes as name, value]
        ${name}="${value}"
    [/#list]
[/#macro]
