package com.example.sanpa.view.helper;

import com.example.sanpa.biz.mother.MotherVO;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Balance;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Service
public class CoolsmsService {

    private final DefaultMessageService messageService;

    public CoolsmsService() {
        this.messageService = NurigoApp.INSTANCE.initialize("NCSX899AZWANWP0L", "QVVOA1KHQW6AZMZKGTVOMQEYUTNNCTRW", "https://api.coolsms.co.kr");
    }//CoolsmsService()-end

    public SingleMessageSentResponse sendOne(){
        Message message = new Message();

        message.setFrom("01090611355");
        message.setTo("01086062967");
        message.setText("산모즈 파트너\n\n등록하신 산모님의 A버튼 도움 알림을 발송합니다.");
        SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
        return response;

    }//sendOne()-end


    public List<SingleMessageSentResponse> sendAStatusToMany(List<MotherVO> telList) throws IOException {
        List<SingleMessageSentResponse> responses = new ArrayList<>();
        for (MotherVO tel : telList) {
            Message message = new Message();
            String number = tel.getHelper_tel();
            message.setFrom("01090611355");
            message.setTo(number);
            message.setText("산모즈 파트너\n\n등록하신 산모님의 A버튼 도움 알림을 발송합니다.");

            SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
            responses.add(response);
        }
        return responses;
    }//sendAStatusToMany()-end

    public List<SingleMessageSentResponse> sendBStatusToMany(List<MotherVO> telList) throws IOException {
        List<SingleMessageSentResponse> responses = new ArrayList<>();
        for (MotherVO tel : telList) {
            Message message = new Message();
            String number = tel.getHelper_tel();
            message.setFrom("01090611355");
            message.setTo(number);
            message.setText("산모즈 파트너\n\n등록하신 산모님의 B버튼 도움 알림을 발송합니다.");

            SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
            responses.add(response);
        }
        return responses;
    }//sendBStatusToMany()-end


    public void getBalance() {
        Balance balance = this.messageService.getBalance();
        System.out.println("남은 금액: " + balance + "!!!!!!!!!!");
    }//getBalance()-end





}//CoolsmsService()-end
