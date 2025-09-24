package vn.iotstar.tuan7.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import vn.iotstar.tuan7.service.SqlService;

@Controller
public class SqlGatewayController {

    @Autowired
    private SqlService sqlService;

    @GetMapping("/sqlGateway")
    public String getForm(Model model) {
        model.addAttribute("sqlStatement", "SELECT 1;");
        model.addAttribute("sqlResult", "");
        return "sqlGateway";
    }

    @PostMapping("/sqlGateway")
    public String executeSql(@RequestParam(name = "sqlStatement", required = false) String sqlStatement,
                             Model model) {
        String result = sqlService.executeSql(sqlStatement);
        model.addAttribute("sqlStatement", sqlStatement);
        model.addAttribute("sqlResult", result);
        return "sqlGateway";
    }
}
