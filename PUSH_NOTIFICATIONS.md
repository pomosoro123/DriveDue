# Push Notifications Setup Guide

This document provides instructions for setting up and testing push notifications in the DueDrive Alerts application.

## Prerequisites

1. Firebase Project with Cloud Messaging (FCM) enabled
2. Supabase Project with Edge Functions
3. Web server with HTTPS (required for service workers)

## Setup Instructions

### 1. Firebase Configuration

1. Go to the [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or select an existing one
3. Navigate to Project Settings > Cloud Messaging
4. Under "Web configuration" click "Generate key pair" to create a VAPID key
5. Note the following values:
   - Project ID
   - Web API Key
   - VAPID Key

### 2. Supabase Configuration

1. Go to your Supabase project settings
2. Navigate to API > Config
3. Add the following environment variables:

```
# Firebase Configuration
FIREBASE_PROJECT_ID=your-project-id
FIREBASE_PRIVATE_KEY=your-private-key
FIREBASE_CLIENT_EMAIL=your-client-email
FIREBASE_SERVER_KEY=your-server-key
FIREBASE_VAPID_KEY=your-vapid-key

# For local development
SUPABASE_URL=your-supabase-url
SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
```

### 3. Database Setup

Run the database migration to create the required tables:

```bash
# Apply migrations
supabase migration up
```

### 4. Deploy Edge Functions

Deploy the Edge Functions to Supabase:

```bash
# Deploy all functions
supabase functions deploy --no-verify-jwt send-expiration-alerts
supabase functions deploy --no-verify-jwt test-push-notification
```

## Testing Push Notifications

### 1. Local Development

1. Start the development server:
   ```bash
   npm run dev
   ```

2. Navigate to the test page:
   ```
   http://localhost:3000/test-push-notifications
   ```

3. Click "Enable Push Notifications" to request permission

4. Click "Send Test Notification" to verify the setup

### 2. Production Testing

1. Deploy your application
2. Navigate to the test page on your production URL
3. Follow the same steps as local development

## Troubleshooting

### Common Issues

1. **Push Notifications Not Working in Development**
   - Ensure you're using HTTPS in production (required for service workers)
   - For local development, Chrome allows service workers on `localhost` with HTTP

2. **Permission Denied**
   - Check if notifications are blocked in browser settings
   - Clear site data and try again

3. **FCM Token Not Generated**
   - Verify Firebase configuration
   - Check browser console for errors
   - Ensure the Firebase SDK is properly initialized

4. **Test Notifications Not Received**
   - Check the browser's console for errors
   - Verify the Edge Function logs in Supabase
   - Ensure the FCM token is valid and not expired

## Implementation Details

### Key Files

- `public/firebase-messaging-sw.js` - Service worker for handling push notifications
- `src/lib/firebase.ts` - Firebase initialization and messaging utilities
- `src/hooks/usePushNotifications.ts` - React hook for push notifications
- `src/components/settings/NotificationSettings.tsx` - UI for notification preferences
- `src/pages/TestPushNotifications.tsx` - Test page for push notifications
- `supabase/functions/send-expiration-alerts/` - Edge Function for sending alerts
- `supabase/functions/test-push-notification/` - Edge Function for testing

### Data Flow

1. User grants notification permission
2. FCM token is generated and stored in `user_fcm_tokens`
3. When a notification needs to be sent:
   - The backend calls the appropriate Edge Function
   - The Edge Function sends the notification via FCM
   - The service worker receives the push event and displays the notification

## Security Considerations

1. Always use HTTPS in production
2. Keep Firebase credentials secure
3. Validate user permissions before sending notifications
4. Implement rate limiting on notification endpoints
5. Handle token expiration and refresh

## Next Steps

1. Implement notification categories and user preferences
2. Add support for rich notifications with actions
3. Implement notification analytics
4. Set up A/B testing for notification content
