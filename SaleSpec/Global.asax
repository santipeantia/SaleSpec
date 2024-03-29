﻿<%@ Application Language="C#" %>
<%@ Import Namespace="System.Web.Routing" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        RegisterRoutes(RouteTable.Routes);
    }

    static void RegisterRoutes(RouteCollection routes)
    {
        //routes.MapPageRoute("login", "login", "~/login.aspx");

        routes.MapPageRoute("pages/dashboard", "pages/dashboard", "~/pages/dashboard.aspx");
        routes.MapPageRoute("pages/default", "pages/default", "~/pages/default.aspx");
        routes.MapPageRoute("pages/users/login", "pages/users/login", "~/pages/users/login.aspx");
        routes.MapPageRoute("pages/users/logout", "pages/users/logout", "~/pages/users/logout.aspx");
        routes.MapPageRoute("pages/users/changepassword", "pages/users/changepassword", "~/pages/users/changepassword.aspx");

        routes.MapPageRoute("pages/masters/customertype", "pages/masters/customertype", "~/pages/masters/customertype.aspx");
        routes.MapPageRoute("pages/masters/customergrade", "pages/masters/customergrade", "~/pages/masters/customergrade.aspx");
        routes.MapPageRoute("pages/masters/productgroup", "pages/masters/productgroup", "~/pages/masters/productgroup.aspx");
        routes.MapPageRoute("pages/masters/specifier", "pages/masters/specifier", "~/pages/masters/specifier.aspx");
        routes.MapPageRoute("pages/masters/architect", "pages/masters/architect", "~/pages/masters/architect.aspx");
        routes.MapPageRoute("pages/masters/customer", "pages/masters/customer", "~/pages/masters/customer.aspx");
        routes.MapPageRoute("pages/masters/company", "pages/masters/company", "~/pages/masters/company.aspx");
        routes.MapPageRoute("pages/masters/projectsetup", "pages/masters/projectsetup", "~/pages/masters/projectsetup.aspx");
        
        routes.MapPageRoute("pages/trans/apprequest", "pages/trans/apprequest", "~/pages/trans/apprequest.aspx");

        routes.MapPageRoute("pages/trans/apprequest-new", "pages/trans/apprequest-new", "~/pages/trans/apprequest-new.aspx");

        routes.MapPageRoute("pages/trans/weeklyreport", "pages/trans/weeklyreport", "~/pages/trans/weeklyreport.aspx");
        routes.MapPageRoute("pages/trans/weeklyreport-update", "pages/trans/weeklyreport-update", "~/pages/trans/weeklyreport-update.aspx");
        
        routes.MapPageRoute("pages/trans/projects", "pages/trans/projects", "~/pages/trans/projects.aspx");
        routes.MapPageRoute("pages/trans/projects-update", "pages/trans/projects-update", "~/pages/trans/projects-update.aspx");
        routes.MapPageRoute("pages/trans/projects-update-status", "pages/trans/projects-update-status", "~/pages/trans/projects-update-status.aspx");
        routes.MapPageRoute("pages/trans/saleonspec", "pages/trans/saleonspec", "~/pages/trans/saleonspec.aspx");
        routes.MapPageRoute("pages/trans/sosprojectmapping", "pages/trans/sosprojectmapping", "~/pages/trans/sosprojectmapping.aspx");
        routes.MapPageRoute("pages/trans/saleonspecfilter", "pages/trans/saleonspecfilter", "~/pages/trans/saleonspecfilter.aspx");        
        
        routes.MapPageRoute("pages/trans/mmcondition", "pages/trans/mmcondition", "~/pages/trans/mmcondition.aspx");
        routes.MapPageRoute("pages/trans/mmgoodcust", "pages/trans/mmgoodcust", "~/pages/trans/mmgoodcust.aspx");
        routes.MapPageRoute("pages/trans/mmproducts", "pages/trans/mmproducts", "~/pages/trans/mmproducts.aspx");
        routes.MapPageRoute("pages/trans/mmreport", "pages/trans/mmreport", "~/pages/trans/mmreport.aspx");
        routes.MapPageRoute("pages/trans/mmprojectcontact", "pages/trans/mmprojectcontact", "~/pages/trans/mmprojectcontact.aspx");

        routes.MapPageRoute("pages/report/saleweeklyreport", "pages/report/saleweeklyreport", "~/pages/report/saleweeklyreport.aspx");
        routes.MapPageRoute("pages/report/newprojectreport", "pages/report/newprojectreport", "~/pages/report/newprojectreport.aspx");

        routes.MapPageRoute("pages/report/companyreport", "pages/report/companyreport", "~/pages/report/companyreport.aspx");
        routes.MapPageRoute("pages/report/companyreportview", "pages/report/companyreportview", "~/pages/report/companyreportview.aspx");
        

        routes.MapPageRoute("pages/report/architectreport", "pages/report/architectreport", "~/pages/report/architectreport.aspx");
        routes.MapPageRoute("pages/report/architectprofile", "pages/report/architectprofile", "~/pages/report/architectprofile.aspx");
        
        routes.MapPageRoute("pages/report/projectreport", "pages/report/projectreport", "~/pages/report/projectreport.aspx");
        routes.MapPageRoute("pages/report/forecastingreport", "pages/report/forecastingreport", "~/pages/report/forecastingreport.aspx");
        routes.MapPageRoute("pages/report/specintakereport", "pages/report/specintakereport", "~/pages/report/specintakereport.aspx");
        routes.MapPageRoute("pages/report/specintakeview", "pages/report/specintakeview", "~/pages/report/specintakeview.aspx");


        routes.MapPageRoute("pages/report/activity_event", "pages/report/activity_event", "~/pages/report/activity_event.aspx");
        routes.MapPageRoute("pages/report/activity_reward", "pages/report/activity_reward", "~/pages/report/activity_reward.aspx");
        
        
            
        routes.MapPageRoute("pages/activity/eventactivity", "pages/activity/eventactivity", "~/pages/activity/eventactivity.aspx");
        routes.MapPageRoute("pages/activity/premiumgift", "pages/activity/premiumgift", "~/pages/activity/premiumgift.aspx");
        routes.MapPageRoute("pages/activity/surprisegift", "pages/activity/surprisegift", "~/pages/activity/surprisegift.aspx");

        


    }


</script>
