#include <iostream>
#include <random>
#include <string>

#include "httplib/httplib.h"
#include "json/json.hpp"

using json = nlohmann::json;

std::string generateToken()
{
    static const char charset[] =
        "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

    std::string token = "EC-";

    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> dis(0, sizeof(charset)-2);

    for(int i=0;i<12;i++)
        token += charset[dis(gen)];

    return token;
}

int main()
{
    httplib::Server server;

    server.Post("/generate-token",
        [](const httplib::Request&, httplib::Response& res)
    {
        json response;

        response["token"]=generateToken();
        response["status"]="CREATED";

        res.set_content(response.dump(4),"application/json");
    });

    server.Post("/validate-token",
        [](const httplib::Request&, httplib::Response& res)
    {
        json response;

        response["valid"]=true;

        res.set_content(response.dump(4),"application/json");
    });

    std::cout<<"===================================="<<std::endl;
    std::cout<<" PayPal Token Service Started"<<std::endl;
    std::cout<<" Listening on port 8080"<<std::endl;
    std::cout<<"===================================="<<std::endl;

    std::cout << "Starting Token Service..." << std::endl;

    if (!server.listen("0.0.0.0", 8085))
    {
      std::cerr << "Failed to bind to port 8085" << std::endl;
      return 1;
    }
    
    return 0;
}
