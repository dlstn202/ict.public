package com.ict.finalproject.service;

import java.io.File;
import java.nio.file.Files;
import java.security.SecureRandom;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.ict.finalproject.dao.ReservationMapper;
import com.ict.finalproject.vo.QnaVo;
import com.ict.finalproject.vo.ReservationVo;

import jakarta.mail.MessagingException;
import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.ServletContext;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmailService {

    private final JavaMailSender javaMailSender;  // 의존성 주입을 통해 필요한 객체를 가져옴
    private static final String senderEmail= "camprover1@gmail.com";
    private static int number;  // 랜덤 인증 코드
    private static String pwd;  // 랜덤 임시 비밀번호

    private static final char[] rndAllCharacters = new char[]{
        //number
        '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
        // //uppercase
        // 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
        // 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
        //lowercase
        'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
        'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z',
        //special symbols
        '@','#', '$', '!', '%', '*', '?', '&', '^', '_'
    };
    
    @Autowired
	ServletContext application; //절대경로 구하기용

    // 랜덤 인증 코드 생성
    public void createNumber() {
        number = (int)(Math.random() * (90000)) + 100000;// (int) Math.random() * (최댓값-최소값+1) + 최소값
    }

    public void createPwd() {
        SecureRandom random = new SecureRandom();
        StringBuilder stringBuilder = new StringBuilder();

        int rndAllCharactersLength = rndAllCharacters.length;
        for (int i = 0; i < 10; i++) {
            stringBuilder.append(rndAllCharacters[random.nextInt(rndAllCharactersLength)]);
        }

        pwd = stringBuilder.toString();

        // // 최소 8자리에 대문자, 소문자, 숫자, 특수문자 각 1개 이상 포함
        // String pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}";
        // if (!Pattern.matches(pattern, randomPassword)) {
        //     createPwd();    //비밀번호 조건(패턴)에 맞지 않는 경우 메서드 재실행
        // }
    }

    // 메일 양식(인증코드)
    public MimeMessage EmailCheck(String mail, String filename) throws MessagingException{
        createNumber();  // 인증 코드 생성
        MimeMessage message = javaMailSender.createMimeMessage();


        try {
            String abs_path = application.getRealPath("/mailForm/");
            File f = new File(abs_path, filename);
            String content = new String(Files.readAllBytes(f.toPath()), "UTF-8");
           
            // 파일 내용에서 ${number}를 실제 인증 번호로 교체
            content = content.replace("${number}", String.valueOf(number));
            
            
            message.setFrom(senderEmail); // 보내는 이메일
            message.setRecipients(MimeMessage.RecipientType.TO, mail); // 보낼 이메일 설정
            message.setSubject("[camprover] 이메일 인증"); // 제목 설정
            message.setText(content, "UTF-8", "html"); // 메일 본문 설정
            } catch (Exception e) {
            e.printStackTrace();
        }

       
        return message;
    }

    // 메일 양식(온라인문의 답글)
    public MimeMessage EmailAnswer(String email, String filename, QnaVo vo) throws MessagingException{

        MimeMessage message = javaMailSender.createMimeMessage();

        try {
            String abs_path = application.getRealPath("/mailForm/");
            File f = new File(abs_path, filename);
            String content = new String(Files.readAllBytes(f.toPath()), "UTF-8");
            // String content = new String(Files.readAllBytes(Paths.get(filePath)), "UTF-8");
            // 파일 내용에서 ${number}를 실제 인증 번호로 교체
            content = content.replace("${name}", vo.getQna_name());
            content = content.replace("${date}", vo.getQna_date());
            content = content.replace("${title}", vo.getQna_title());
            
            message.setFrom(senderEmail); // 보내는 이메일
            message.setRecipients(MimeMessage.RecipientType.TO, email); // 보낼 이메일 설정
            message.setSubject("[camprover] 문의 답변"); // 제목 설정
            message.setText(content, "UTF-8", "html"); // 메일 본문 설정
            } catch (Exception e) {
            e.printStackTrace();
        }

       
        return message;
    }
    // 메일 양식(예약)
    public MimeMessage EmailReceipt(ReservationVo vo, String filename, String html) throws MessagingException{

        MimeMessage message = javaMailSender.createMimeMessage();

        try {
            String abs_path = application.getRealPath("/mailForm/");
            File f = new File(abs_path, filename);
            String content = new String(Files.readAllBytes(f.toPath()), "UTF-8");
            // String content = new String(Files.readAllBytes(Paths.get(filePath)), "UTF-8");
            // 파일 내용에서 ${number}를 실제 인증 번호로 교체
            content = content.replace("${name}", vo.getMem_name());
            content = content.replace("${date}", vo.getRes_date());
            content = content.replace("${facltNm}", vo.getFacltNm());
            content = content.replace("${start}", vo.getRes_checkindate());
            content = content.replace("${end}", vo.getRes_checkoutdate());
            
            message.setFrom(senderEmail); // 보내는 이메일
            message.setRecipients(MimeMessage.RecipientType.TO, vo.getMem_email()); // 보낼 이메일 설정
            message.setSubject("[camprover] 예약 완료"); // 제목 설정
            message.setText(content, "UTF-8", "html"); // 메일 본문 설정
            } catch (Exception e) {
            e.printStackTrace();
        }

       
        return message;
    }

    // 메일 양식(예약 취소)
    public MimeMessage EmailResCancle(ReservationVo vo, String filename) throws MessagingException{

        MimeMessage message = javaMailSender.createMimeMessage();

        try {
            String abs_path = application.getRealPath("/mailForm/");
            File f = new File(abs_path, filename);
            String content = new String(Files.readAllBytes(f.toPath()), "UTF-8");
            // String content = new String(Files.readAllBytes(Paths.get(filePath)), "UTF-8");
            // 파일 내용에서 ${number}를 실제 인증 번호로 교체
            content = content.replace("${name}", vo.getMem_name());
            content = content.replace("${date}", vo.getRes_date());
            content = content.replace("${facltNm}", vo.getFacltNm());
            content = content.replace("${start}", vo.getRes_checkindate());
            content = content.replace("${end}", vo.getRes_checkoutdate());
            
            message.setFrom(senderEmail); // 보내는 이메일
            message.setRecipients(MimeMessage.RecipientType.TO, vo.getMem_email()); // 보낼 이메일 설정
            message.setSubject("[camprover] 예약 취소"); // 제목 설정
            message.setText(content, "UTF-8", "html"); // 메일 본문 설정
            } catch (Exception e) {
            e.printStackTrace();
        }

       
        return message;
    }

    // 메일 양식(임시비밀번호)
    public MimeMessage EmailPwd(String email, String filename) throws MessagingException{

        createPwd();

        MimeMessage message = javaMailSender.createMimeMessage();

        try {
            String abs_path = application.getRealPath("/mailForm/");
            File f = new File(abs_path, filename);
            String content = new String(Files.readAllBytes(f.toPath()), "UTF-8");
            // String content = new String(Files.readAllBytes(Paths.get(filePath)), "UTF-8");
            // 파일 내용에서 ${number}를 실제 인증 번호로 교체
            content = content.replace("${pwd}", pwd);
            
            message.setFrom(senderEmail); // 보내는 이메일
            message.setRecipients(MimeMessage.RecipientType.TO, email); // 보낼 이메일 설정
            message.setSubject("[camprover] 임시 비밀번호 발급"); // 제목 설정
            message.setText(content, "UTF-8", "html"); // 메일 본문 설정
            } catch (Exception e) {
            e.printStackTrace();
        }

       
        return message;
    }

    // 인증 메일 발송(난수)
    public int sendCheck(String email) throws MessagingException {
        //이메일폼
        String filename = "EmailCheck.html";
        // 메일 전송에 필요한 정보 설정
        MimeMessage message = EmailCheck(email, filename);
        // 실제 메일 전송
        javaMailSender.send(message);
        // 인증 코드 반환
        return number;
    }

    // 인증 메일 발송(임시비밀번호)
    public String sendPWD(String email) throws MessagingException {
        //이메일폼
        String filename = "EmailPwd.html";
        // 메일 전송에 필요한 정보 설정
        MimeMessage message = EmailPwd(email, filename);
        // 실제 메일 전송
        javaMailSender.send(message);
        // 인증 코드 반환
        return pwd;
    }

    // 문의 답글이 등록됨
    public void sendInsertAnswer(String email,QnaVo vo) throws MessagingException {
        //이메일폼
        String filename = "AnswerInsert.html";
        // 메일 전송에 필요한 정보 설정
        MimeMessage message = EmailAnswer(email,filename, vo);
        // 실제 메일 전송
        javaMailSender.send(message);

    }

    // 문의 답글이 수정됨
    public void sendModifyAnswer(String email, QnaVo vo) throws MessagingException {
        //이메일폼
        String filename = "AnswerModify.html";
        // 메일 전송에 필요한 정보 설정
        MimeMessage message = EmailAnswer(email,filename, vo);
        // 실제 메일 전송
        javaMailSender.send(message);

    }

    // 결제정보
    public void sendReceipt(ReservationVo vo, String html) throws MessagingException {
        //이메일폼
        String filename = "Receipt.html";
        // 메일 전송에 필요한 정보 설정
        MimeMessage message = EmailReceipt(vo,filename, html);
        // 실제 메일 전송
        javaMailSender.send(message);

    }

    // 예약취소
    public void sendResCancle(ReservationVo vo) throws MessagingException {
        //이메일폼
        String filename = "ResCancle.html";
        // 메일 전송에 필요한 정보 설정
        MimeMessage message = EmailResCancle(vo,filename);
        // 실제 메일 전송
        javaMailSender.send(message);

    }




}
