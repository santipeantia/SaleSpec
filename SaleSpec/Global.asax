<%@ Application Language="C#" %>
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

        routes.MapPageRoute("pages/masters/customertype", "pages/masters/customertype", "~/pages/masters/customertype.aspx");
        routes.MapPageRoute("pages/masters/customergrade", "pages/masters/customergrade", "~/pages/masters/customergrade.aspx");
        routes.MapPageRoute("pages/masters/productgroup", "pages/masters/productgroup", "~/pages/masters/productgroup.aspx");
        routes.MapPageRoute("pages/masters/specifier", "pages/masters/specifier", "~/pages/masters/specifier.aspx");
        routes.MapPageRoute("pages/masters/architect", "pages/masters/architect", "~/pages/masters/architect.aspx");
        routes.MapPageRoute("pages/masters/customer", "pages/masters/customer", "~/pages/masters/customer.aspx");
        

    }

       
</script>
