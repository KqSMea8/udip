package com.alibaba.otter.manager.web.home.module.screen;

import com.alibaba.citrus.turbine.Context;
import com.alibaba.citrus.turbine.dataresolver.Param;
import com.alibaba.citrus.util.Paginator;
import com.hwl.otter.clazz.tablerel.CheckTableRelService;
import com.hwl.otter.clazz.tablerel.dal.dataobject.CheckTableRelDo;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CheckTableRelList {

    @Resource(name = "checkTableRelService")
    private CheckTableRelService checkTableRelService;

    public void execute(@Param("pageIndex") int pageIndex, @Param("searchKey") String searchKey,
                        Context context) throws Exception {
        Map<String, Object> condition = new HashMap<String, Object>();
        if ("请输入关键字".equals(searchKey)) {
            searchKey = "";
        }
        condition.put("searchKey", searchKey);

        int count = checkTableRelService.getCount(condition);
        Paginator paginator = new Paginator();
        paginator.setItems(count);
        paginator.setPage(pageIndex);

        condition.put("offset", paginator.getOffset());
        condition.put("length", paginator.getLength());

        List<CheckTableRelDo> checkTableRelLs = checkTableRelService.listCheckTableRel(condition);


        context.put("checkTableRelLs", checkTableRelLs);
        context.put("paginator", paginator);
        context.put("searchKey", searchKey);
    }


}
