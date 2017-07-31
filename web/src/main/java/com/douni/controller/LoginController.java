package com.douni.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.Random;

/**
 * Created by jia on 2017/7/28.
 */
@Controller

public class LoginController {
    Logger logger= LoggerFactory.getLogger(LoginController.class);


    @RequestMapping(value = "/login", method = RequestMethod.POST)
    public Object login(HttpServletRequest request, HttpServletResponse response) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String code=request.getParameter("code").trim();
        String codeS=request.getSession().getAttribute("imageMask")+"";
        if (!code.equals(codeS)){
            request.setAttribute("msg","验证码错误，请确认后输入！");
            return  "../index";
        }
        boolean flag=false;
        if(username.equals("jack")&&password.equals("love")){
            flag=true;
        }
        if(flag){
            return "redirect:/jsp/chatRoom.jsp";
        }else {
            request.setAttribute("msg","用户名或密码错误，请稍后再试！");
            return  "../index";
        }
    }
    /**
     * 图片验证码
     * @param request
     * @param response
     */
    @RequestMapping("/ImageMaskServlet")
    public void ImageMask(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);

        int width = 60, height = 20;
        //创建图象
        BufferedImage image = new BufferedImage(width, height,BufferedImage.TYPE_INT_RGB);
        //获取图形上下文
        Graphics graphics = image.getGraphics();
        //生成随机类
        Random random = new Random();
        //设定背景色
        graphics.setColor(getRandColor(200, 250));
        //验证码大小
        graphics.fillRect(0, 0, width, height);
        //设置字体
        graphics.setFont(new Font("Times New Roman", Font.PLAIN, 18));
        //graphics.setColor(getRandColor(160, 200));
        //随机产生155条干扰线，使图象中的认证码不易被其它程序探测到
        for (int i = 0; i < 155; i++) {
            int x = random.nextInt(width);
            int y = random.nextInt(height);
            int xl = random.nextInt(12);
            int yl = random.nextInt(12);
            graphics.drawLine(x, y, x + xl, y + yl);
        }
        //取随机产生的认证码(4位数字)
        String sRand = "";
        for (int i = 0; i < 4; i++) {
            //0~9
            String rand = String.valueOf(random.nextInt(10));
            sRand += rand;
            //设置数字颜色
            graphics.setColor(new Color(20 + random.nextInt(110), 20 + random.nextInt(110), 20 + random.nextInt(110)));
            //把随机产生的4位数画在图片上
            graphics.drawString(rand, 13 * i + 6, 16);
        }
        logger.info("imageMask:{}",sRand);
        //放在session中
        request.getSession().setAttribute("imageMask", sRand);
        //图象生效
        graphics.dispose();
        //输出图象到页面
        ImageIO.write(image, "JPEG", response.getOutputStream());
    }

    //生成随机颜色
    public Color getRandColor(int fc, int bc) {
        Random random = new Random();
        if (fc > 255){
            fc = 255;
        }
        if (bc > 255){
            bc = 255;
        }
        int r = fc + random.nextInt(bc - fc);
        int g = fc + random.nextInt(bc - fc);
        int b = fc + random.nextInt(bc - fc);
        return new Color(r, g, b);
    }

}
