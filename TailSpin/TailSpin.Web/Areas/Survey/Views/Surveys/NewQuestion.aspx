﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" 
         Inherits="System.Web.Mvc.ViewPage<TailSpin.Web.Models.TenantPageViewData<TailSpin.Web.Survey.Shared.Models.Question>>" %>
<%@ Import Namespace="TailSpin.Web.Utility" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MenuContent" runat="server">
    <ul>
        <li class="current"><a>New Survey</a></li>
        <li><%:Html.ActionLink("My Surveys", "Index", "Surveys")%></li>
        <li><%:Html.ActionLink("My Account", "Index", "Account", new {area = string.Empty}, null)%></li>
    </ul>
    <div class="clear">
    </div>
</asp:Content>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="breadcrumbs">
        <a href="#" onclick="javascript: submitToCancelNewQuestion()">New Survey</a> &gt; 
        New Question
    </div>

    <h2>Add a new question</h2>
    <br />
    <% using (Html.BeginForm("AddQuestion", "Surveys")) {%>
        <%: Html.ValidationSummary(true) %>
        <%: Html.Serialize("hiddenSurvey")%>
        <%: Html.Hidden("referrer", "addQuestion") %>

        <dl>
            <dt>
                <%: Html.LabelFor(model => model.ContentModel.Text) %>
            </dt>
            <dd>
                <%: Html.TextBoxFor(model => model.ContentModel.Text, new { size = "60" })%>
                <%: Html.ValidationMessageFor(model => model.ContentModel.Text)%>
            </dd>
            <dt>
                <%: Html.LabelFor(model => model.ContentModel.Type)%>
            </dt>
            <dd>
                <%: Html.EnumDropDownListFor(model => model.ContentModel.Type)%>
            </dd>
        </dl>

        <div id="possibleAnswers" style="display: none">
            <dl>
                <dt>
                    <%: Html.LabelFor(model => model.ContentModel.PossibleAnswers) %><br />
                    <span id="questionTypeHelp" style="font-style: italic; font-weight: normal;">Enter one choice per line</span>
                </dt>
                <dd>
                    <%: Html.TextAreaFor(model => model.ContentModel.PossibleAnswers, new { rows = "5", cols = "1", style = "width: 500px;" })%>
                    <%: Html.ValidationMessageFor(model => model.ContentModel)%>
                </dd>
            </dl>
        </div>

        <br />
        <%:Html.AntiForgeryToken() %>
        <p>
            <input id="addToSurvey" type="submit" value="Add to survey" />
             or 
            <a href="#" onclick="javascript: submitToCancelNewQuestion()">Cancel</a>
        </p>
    <% } %>

    <link href="<%:Url.Content("~/Content/styles/baseStyle.css")%>" rel="stylesheet" type="text/css" media="screen" />
    <script src="<%:Url.Content("~/Scripts/jquery-1.4.1.min.js")%>" language="javascript" type="text/javascript"></script>
    <script type="text/javascript">
        function submitToCancelNewQuestion() {
            document.forms[0].action = '<%= Url.Action("CancelNewQuestion", "Surveys")%>'
            document.forms[0].submit();
        }

        function setAnswersVisibility() {
            var selectedType = $("select option:selected").text()
            if (selectedType != 'Multiple choice') {
                $('textarea').val('')
                $('#possibleAnswers').hide()
            }
            else {
                $('#possibleAnswers').show()
            }
        }

        $('select').change(setAnswersVisibility);

        $(document).ready(setAnswersVisibility);

    </script>
</asp:Content>

